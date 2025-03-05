import org.flywaydb.core.Flyway;

public class FlywayMigration {
    public static void main(String[] args) {
        Flyway flyway = Flyway.configure()
                .dataSource("jdbc:postgresql://localhost:5432/postgres", "postgres", "root")
                .baselineOnMigrate(true)
                .load();

        flyway.migrate();
        System.out.println("База синхронизирована с Flyway!");
    }
}
